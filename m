Message-ID: <5343E392.1010803@...1800...>
Date: Tue, 08 Apr 2014 07:54:58 -0400
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
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
To: Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 4/8/2014 7:47 AM, Adriaan de Jong wrote:
>> Using the tls-auth option should protect against this vulnerability (assuming that your tls-auth key is not known to the attacker).
>
>> If you're not using tls-auth and are using a vulnerable version of OpenSSL, you should definitely upgrade to OpenSSL 1.0.1g.
>
> Note that you should also replace both server and client private keys, as these can be read by an attacker.

Perhaps a dumb question, but if the server instance is linked against an 
older version of openssl (9.8.x), but the client is compiled and linked 
against the vulnerable version, is it still an issue for both sides, or 
is the client going to leak private information ?

	---Mike


-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

