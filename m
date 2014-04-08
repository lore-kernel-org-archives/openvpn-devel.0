Message-ID: <534401D6.1080604@...1800...>
Date: Tue, 08 Apr 2014 10:04:06 -0400
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...>
	<0LikyX-1X9YfO48dR-00d2sy@...1825...>	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
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

On 4/8/2014 9:42 AM, Steffan Karger wrote:

>> Perhaps a dumb question, but if the server instance is linked against
>> an older version of openssl (9.8.x), but the client is compiled and
>> linked against the vulnerable version, is it still an issue for both
>> sides, or is the client going to leak private information ?
>
> The client can then leak keys (both private master key and session keys), which completely breaks your secure connection, for that client.
>
> So when the server is not vulnerable, each client has to be attacked individually, and not-vulnerable clients have a secure connection to the server. As long as there are vulnerable clients, you should consider those as potentially malicious, and thus you should consider the network as insecure.

Thanks for the replay. I am still trying to understand as it relates to 
the analysis here

http://blog.existentialize.com/diagnosis-of-the-openssl-heartbleed-bug.html

How does one attack the client ? In my case, the client only connects to 
my servers ? I use a tls-auth key file as well. If I understand 
correctly, the scenario would be the attacker would have to have the 
tls-auth key file, and then do a man in the middle attack to pretend its 
the server's IP, and then coax the client into allocating the 64k block 
of memory as described in the above link ?

	---Mike

-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

