Message-ID: <031501c22123$b1cd50f0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <200207011050.AA00026@...29...>
Subject: Re: [Openvpn-devel] --cert and --key
MIME-Version: 1.0
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
Date: Mon Jul  1 11:39:59 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: TANABE Hiroyasu <h@...28...>, openvpn-devel@lists.sourceforge.net

> Hello all,
>
> I'm confusing with TLS Mode Options.
>
> in Man Page:
> --cert file  Peer's signed certificate in .pem
> --key file   My private key in .pem
> but in Example 3:
> openvpn ... --cert client.crt --key client.key ...
> openvpn ... --cert server.crt --key server.key ...
>
> OpenVPN 1.2.1 works fine with the example,
> but I don't know which is appropriate description for SSL security.
> Which is right?
>
> Thanks in advance,
>
> TANABE Hiroyasu

That's a good point and deserves clarification.  --cert and --key should
point to the local machine's certificate and key.  So the man page should
read something like:

--cert file  Local signed certificate in .pem
--key file   Local private key in .pem

Basically each computer that runs OpenVPN should have it's own
certificate/key pair, signed by the root certificate which is specified
in --ca.

When 2 OpenVPN peers connect, each presents its local certificate to the
other.  Each peer will then check that its partner peer presented a
certificate which was signed by the master --ca certificate.

If that check succeeds, then the TLS negotiation will succeed, both OpenVPN
peers will exchange temporary session keys, and the tunnel will begin
passing data.

James



