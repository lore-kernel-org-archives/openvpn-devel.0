Subject: Re: [Openvpn-devel] a replacement for --tls-remote and verify-cn
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1067287739.82961@...41...>
In-Reply-To: <1067263967.14300.265.camel@...125...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 27 12:53:07 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>, openvpn-devel@lists.sourceforge.net

Teemu Kiviniemi <teemuki@...124...> said:

> Hi,
> 
> I ran into problems in using --tls-verify to verify the remote host with
> --chroot enabled. --tls-verify runs the verify script with system()
> command, so it assumes that /bin/sh is available. Usually, in a chroot
> environment, that's not true.
> 
> I implemented a new config option: --tls-remote x509name
> 
> With --tls-remote the remote host is verified by looking at the X509
> name. If the remote X509 name doesn't match the given x509name, the
> remote host is rejected.
> 
> With --tls-remote, it's possible to verify remote host even with a
> completely empty chroot directory. --tls-remote also removes the need
> for an external --tls-verify script in most cases.
> 
> Config example:
> tls-remote /O=exampleorg/CN=name
> 
> I have tested the patch with a TLS tunnel on Debian Woody.
> 
> A patch against OpenVPN 1.5 beta12 is available at:
> http://iki.fi/teemuki/openvpn/1.5_beta12-tlsremote.diff

Thanks, that looks like a useful patch.

One thing that would help me to merge it more easily, is if you could recode
against the current CVS which has advanced since beta12 and includes the
--crl-verify patch which touches the same parts of ssl.c as your patch.

The 1.5 beta series exists in the CVS under branch "EXP15".

James


