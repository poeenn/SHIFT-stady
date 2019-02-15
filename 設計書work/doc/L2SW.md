変更する設定値のみ記載する。  
その他の機能は使用しないため、デフォルト値とする。  

参考：[設定マニュアル](https://www.downloads.netgear.com/files/answer_media/jp/support/switch/manual/GS7xxT_SWA_J.pdf)  

## 機種情報
* 製品名  
`XS716T`  
* 仕様  
[データシート](https://jp.netgear.com/images/datasheet/switches/SmartSwitches/XS708T_XS712Tv2_XS716T_XS728T_XS748T_DS.pdf)  
* ファームウェア
`6.6.3.3`  
[サポートページ](https://www.jp.netgear.com/support/product/XS716T.aspx#MIB%20Version%206.6.3.3)  


## System > Management > System Information
* System Name  
`L2SW`  
その他デフォルト（空白）

## System > Management > IP Configuration
* Current Network Configuration Protocol  
`●Static IP Address 〇Dynamic IP Address(BOOTP) 〇Dynamic IP Address(DHCP)`  
* IP Address  
`192.168.20.253`
* Subnet Mask  
`255.255.255.0`
* Default Gateway  
`空欄(空欄にできなければ192.168.20.254)`
* Management VLAN ID  
`20`

## System > Management > Time > Time Configuration
* Clock Source  
NTPサーバを設定する。  
`〇Local ●SNTP`

## System > Management > Time > Time Configuration > SNTP Global Configuration
* Client Mode  
`〇Disable　●Unicast　〇Broadcast`  
* Port  
デフォルト  
* Unicast Poll Interval  
デフォルト  
* Broadcast Poll Interval  
デフォルト  
* Unicast Poll Timeout  
デフォルト  
* Unicast Poll Retry  
デフォルト  
* Time Zone Name  
`JST`  
* Offset Hours  
`9`  
* Offset Minutes  
デフォルト  

## System > Management > Time > Time Configuration > SNTP Server Configuration
* Server Type  
`IPv4`  
* Address  
`10.0.10.253`  
* Port  
デフォルト  
* Priority  
デフォルト  
* Version  
デフォルト  

## Switching > Ports > Port Configuration
| Port | Description      | Port Type | Admin Mode | Port Speed | Physical Status | Link Status | Link Trap | Maximum Frame Size(1518 to 9216) | MAC Address | PortList Bit Offset | ifindex |
|------|------------------|-----------|------------|------------|-----------------|-------------|-----------|----------------------------------|-------------|---------------------|---------|
| g1   | master000.shift  |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 1                   | 1       |
| g2   | node001.shift    |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 2                   | 2       |
| g3   | node002.shift    |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 3                   | 3       |
| g4   | node003.shift    |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 4                   | 4       |
| g5   | node004.shift    |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 5                   | 5       |
| g6   | control000.shift |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 6                   | 6       |
| g7   | compute001.shift |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 7                   | 7       |
| g8   | compute002.shift |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 8                   | 8       |
| g9   | compute003.shift |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 9                   | 9       |
| g10  | compute004.shift |           | Enable     | Auto       |                 |             | Enable    | 1518                             | XXXX        | 10                  | 10      |
| g11  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 11                  | 11      |
| g12  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 12                  | 12      |
| g13  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 13                  | 13      |
| g14  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 14                  | 14      |
| g15  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 15                  | 15      |
| g16  |                  |           | disable    | Auto       |                 |             | Enable    | 1518                             | XXXX        | 16                  | 16      |

## Switching > VLAN > Basic > VLAN Configuration
VLANID 1,2,3はデフォルトで設定されている。削除不可。  

| VLAN ID | VLAN Name  | VLAN Type  |
|---------|------------|------------|
| 1       | Default    | Default    |
| 2       | Auto VoIP  | AUTO VoIP  |
| 3       | Auto-Video | Auto-Video |
| 10      | internal   | Static     |
| 20      | external   | Static     |

## Switching > VLAN > Advanced > VLAN Membership
以下の通り設定(VLAN選んでTにする)
* VLAN1（デフォルト値） : 11-16  
* VLAN10 : 1-5  
* VLAN20 : 6-10  
