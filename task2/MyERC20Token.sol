// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyERC20Token {
    // 代币基本信息
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    // 合约所有者
    address public owner;
    
    // 余额映射
    mapping(address => uint256) public balanceOf;
    
    // 授权映射
    mapping(address => mapping(address => uint256)) public allowance;
    
    // 事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    
    // 修饰符：只有所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    /**
     *  构造函数
     * @param _name 代币名称
     * @param _symbol 代币符号
     * @param _decimals 小数位数
     * @param _initialSupply 初始供应量
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        owner = msg.sender;
        _mint(msg.sender, _initialSupply);
    }
    
    /**
     *  转账函数
     * @param _to 接收地址
     * @param _value 转账金额
     */
    function transfer(address _to, uint256 _value) external returns (bool) {
        require(_to != address(0), "Transfer to zero address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    /**
     *  授权函数
     * @param _spender 被授权地址
     * @param _value 授权金额
     */
    function approve(address _spender, uint256 _value) external returns (bool) {
        require(_spender != address(0), "Approve to zero address");
        
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    /**
     *  授权转账函数
     * @param _from 扣款地址
     * @param _to 接收地址
     * @param _value 转账金额
     */
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        require(_from != address(0), "Transfer from zero address");
        require(_to != address(0), "Transfer to zero address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    /**
     *  铸造函数 - 仅所有者可调用
     * @param _to 接收地址
     * @param _value 铸造金额
     */
    function mint(address _to, uint256 _value) external onlyOwner {
        require(_to != address(0), "Mint to zero address");
        
        _mint(_to, _value);
        emit Mint(_to, _value);
    }
    
    /**
     *  内部铸造函数
     */
    function _mint(address _to, uint256 _value) internal {
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Transfer(address(0), _to, _value);
    }
    
    /**
     *  转移合约所有权
     * @param _newOwner 新所有者地址
     */
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "New owner is zero address");
        owner = _newOwner;
    }
    
    /**
     * 销毁代币
     * @param _value 销毁金额
     */
    function burn(uint256 _value) external {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        
        emit Transfer(msg.sender, address(0), _value);
    }
}