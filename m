Message-ID: <004901c1f2cd$de7f59b0$4b5d33c6@...4...>
From: "James Yonan" <jim@...3...>
References: <017001c1f1d5$a102fc20$0600a8c0@...11...> <20020502.150924.02301395.levitte@...13...> <030301c1f212$cf6b66a0$0600a8c0@...11...> <20020502204306.GA19098@...14...> <040a01c1f2b4$758d15a0$1000000a@...4...> <03af01c1f2b6$a85e8160$0600a8c0@...11...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: OpenVPN and OpenSSL 0.9.7 was: Re: Integration of AES algorith to OpenSSL Crypto library
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri May  3 11:29:20 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Ildar Gabdulline <ildar@...11...>
Cc: openvpn-devel@lists.sourceforge.net

> I'll be glad to receive such patch because I need to integrate AES
algorithm
> to openvpn
> (my boss requested this).

If you can wait a few days, I would recommend waiting for the official 0.9.7
openssl beta which will probably solve the problem.  If you can't wait,
here's a patch:

http://openvpn.sourceforge.net/patch/openssl097.patch

Remember, 0.9.7 is pre-beta at this point so you're on your own.  I have not
extensively tested this patch other than a brief test to confirm that it
fixed the EVP incompatibility.

James



