Message-ID: <1896EA4F53C84141B287C36403D7DE21@...1853...>
From: <debbie10t@...277...>
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>
	<5593EBF6.4060203@...1114...>
Date: Wed, 1 Jul 2015 15:05:44 +0100
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn.list@...1114...
Cc: openvpn-devel@lists.sourceforge.net


----- Original Message ----- 
From: "David Sommerseth" <openvpn.list@...1114...>
To: <debbie10t@...277...>; <openvpn-devel@lists.sourceforge.net>
Cc: "Gert Doering" <gert@...1296...>
Sent: Wednesday, July 01, 2015 2:32 PM
Subject: Re: OpenVPN 2.3.7-I602-x86_64.exe download 404 Error

>
>I have no issues ... try this service and see:
><http://downforeveryoneorjustme.com/swupdate.openvpn.org>;
><http://downforeveryoneorjustme.com/forums.openvpn.net>;
>
>
>-- 
>kind regards,
>
>David Sommerseth

downforeveryoneorjustme.com is not sufficiently fine grained for testing as 
..
it does not test HTTPS:// and
The *only* link which appears to be broken is

   - OpenVPN 2.3.7-I602-x86_64.exe
   https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I602-x86_64.exe

Tried from various PC at various sites:

EG:

My local network
14:46:54 $ wget 
https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I602-x86_64.exe
--2015-07-01 14:47:24--  
https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I602-x86_64.exe
Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.1.12, 
104.28.0.12
Connecting to swupdate.openvpn.org 
(swupdate.openvpn.org)|104.28.1.12|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2015-07-01 14:47:25 ERROR 404: Not Found.

Random Client Network
[root@...2040... test]# wget 
https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I602-x86_64.exe
--2015-07-01 14:48:32--  
https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I602-x86_64.exe
Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.0.12, 
104.28.1.12
Connecting to swupdate.openvpn.org 
(swupdate.openvpn.org)|104.28.0.12|:443... connected.
HTTP request sent, awaiting response... 404 Not Found

Thanks


