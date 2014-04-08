Message-ID: <53440679.8060800@...1800...>
Date: Tue, 08 Apr 2014 10:23:53 -0400
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...>
	<0LikyX-1X9YfO48dR-00d2sy@...1825...>	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
	<534401D6.1080604@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CEF0@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90170093CEF0@...1436...>
Subject: Re: [Openvpn-devel] Heartbleed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 4/8/2014 10:13 AM, Steffan Karger wrote:
> On 08/04/2014 16:04, Mike Tancsa wrote:
>> How does one attack the client ? In my case, the client only connects
>> to my servers ? I use a tls-auth key file as well. If I understand
>> correctly, the scenario would be the attacker would have to have the
>> tls-auth key file, and then do a man in the middle attack to pretend
>> its the server's IP, and then coax the client into allocating the 64k
>> block of memory as described in the above link ?
>
> Correct. But man-in-the-middle can also be something like DNS poisoning.

> If you use TLS-auth, the attacker must have previously obtained the TLS-auth key. When the user base is large, it is not unlikely that one of the users was compromised and should be considered malicious.

Thanks!  Although we are certainly planing to update the vulnerable 
clients, this is not quite as dire and urgent as first described in the 
popular press-- at least as it applies to my client base. We also use IP 
addresses for the target servers in the client configs.

	---Mike

-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

