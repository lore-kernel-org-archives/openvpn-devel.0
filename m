References: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
 <52df2da3-eaf7-5364-510a-f7781d62ea9f@...515...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <917a22d3-dcca-15de-51e8-052c93bc2aed@...277...>
Date: Fri, 17 Jan 2020 12:28:47 +0000
MIME-Version: 1.0
In-Reply-To: <52df2da3-eaf7-5364-510a-f7781d62ea9f@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Summary of the community meeting (16th January
 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The following information is also applicable to *Nix.

With regard to packaging EasyRSA-3 with Windows in the future.

The reason EasyRSA-3 has not been the default package for Windows is due 
to EasyRSA-2 PKI not being suitable for use in EasyRSA-3, due to the layout.

This issue now has a solution: "Easyrsa-upgrade"

Please see:
* https://community.openvpn.net/openvpn/wiki/easyrsa-upgrade
   A work in progress detailing the upgrade procedure.

* 
https://github.com/OpenVPN/easy-rsa/commit/07ec923be13d45d1592e93f08a0157dbc7ed3b4c
   The upgrade script.

In order to use the upgrade, simply copy your EasyRSA-2 PKI (Generally 
found in ./Keys directory under Easy-rsa directory) to Easyrsa3 
directory and run:
'./easyrsa upgrade pki'

Depending on how Easyrsa-3 is packaged, this procedure could be automated.

The Easyrsa-upgrade is currently only available in git/master.
We are planning a standard release quite soon. (Version 3.x.x to be 
confirmed)

Questions and feedback welcome.

Thanks
Richard
-- 

