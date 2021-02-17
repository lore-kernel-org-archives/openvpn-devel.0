From: tincanteksup <tincanteksup@...277...>
Message-ID: <8d6cbe40-bbc0-ddd4-ed5b-1acb9b6967fb@...277...>
Date: Wed, 17 Feb 2021 22:37:45 +0000
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] [Openvpn-devel/users] Debugging Windows based
 server scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

due to not being allowed to have scripts "echo data" to the log file 
under Windows, debugging scripts is next to impossible.

I presume there are no compile time options to enable "echo" under Windows ?

Could anybody provide me with a patch to enable "echo" just for the 
purpose of debugging ?

I would like the patch to work for Openvpn 2.5

I understand the risks and I am not distributing OpenVPN binaries.

As justification I make these points:

* Any large distributor of Openvpn binaries could make the change to 
enable "echo" under Windows.

* That distributor could then abuse it as they please.

* I am simply asking for help for the purpose of debugging Open Source 
Software made for the community.

Thanks.
R

