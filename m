Message-ID: <54423617.2010009@...1856...>
Date: Sat, 18 Oct 2014 11:42:47 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <13177950.74478.1413544590694.JavaMail.root@...1893...>	<54411BA1.9080402@...1227...>	<17844314.87425.1413555693684.JavaMail.root@...1893...>	<CAFHpkQFXzF6D3X8DYHHLzb+gpvYDcVoHR8JKGG1p+o4w_GtFVw@...278...>	<9453768.108293.1413591263095.JavaMail.root@...1893...>
	<CAFHpkQGH3pk1FyLB5bHLPkVQjfwsMhyXyrttJZG_=au5J_Hbpg@...278...>
In-Reply-To: <CAFHpkQGH3pk1FyLB5bHLPkVQjfwsMhyXyrttJZG_=au5J_Hbpg@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform that
 incorporate OpenSSL 1.0.1j
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 18-10-14 05:40, Илья Шипицин wrote:
> how does that affect OpenVPN?
> 
> суббота, 18 октября 2014 г. пользователь Lisa Minogue написал:
> 
>     SRTP Memory Leak (CVE-2014-3513)
>     Session Ticket Memory Leak (CVE-2014-3567)

Denial-of-service only (no integrity or confidentiality breach). Use
tls-auth as an extra layer of protection if you worry about DoS attacks.

>     SSL 3.0 Fallback protection
>     Build option no-ssl3 is incomplete (CVE-2014-3568)

OpenVPN does not use SSLv3. Not affected at all.

-Steffan

