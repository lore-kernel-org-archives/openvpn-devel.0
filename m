Date: Sun, 17 Aug 2025 09:23:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aKGDa4wayQmicrLN@...1296...>
References: <CAOh3LPMi5NcTx+Cu6nEO_Orwcjim4qf2gChsOdsN5trOTdP7qA.ref@...278...>
 <CAOh3LPMi5NcTx+Cu6nEO_Orwcjim4qf2gChsOdsN5trOTdP7qA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xUwlYgxWUiWkmOMX"
Content-Disposition: inline
In-Reply-To: <CAOh3LPMi5NcTx+Cu6nEO_Orwcjim4qf2gChsOdsN5trOTdP7qA@...278...>
Subject: Re: [Openvpn-devel] Nice work on the DCO kernel module - Just had
 some quick questions about it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net

--xUwlYgxWUiWkmOMX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 16, 2025 at 09:38:13PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> able to compile it and insmod it and I think OpenVPN auto picked it up ev=
en
> running in TCP mode I believe. I wanted to confirm, does this DCO module
> work with TCP mode or is it UDP client/server protocol only?

Linux and Windows DCO support TCP mode, FreeBSD DCO does not.

If you select options that are incompatible with DCO (like, "compress", or
"tcp" on FreeBSD) OpenVPN will log that and fall back to userland.

>  Also, I'm not
> very smart and I am unable to understand kernel-level C code as it is very
> abstract and generalized but I was trying to see what read/write buffer
> sizes it uses if I had a TUN MTU of 1500 bytes?

In Kernel, there is no real "read/write" involved.  There is a packet
coming in as part of a data structure, this gets processed, and the
data structure handed onwards.  So it always deals with "one full packet
at a time".

[..]
> I performed a speed test with it also but I could only get the same speed
> as my modified OpenVPN setup (~650Mbps over WiFi 6GHz@...2907...) so I th=
ink
> there is some other limiting factor elsewhere in my network setup. I don't
> have a wired client, only a U7-Pro and I am running the VPN client in the
> middle of my network on a Linux VM on a Mac Mini but it ran pretty smooth=
ly
> and nicely assuming it was indeed working correctly.

Performance measurement is tough, especially with DCO involved, as you end
up measuring something else.  Like "how fast can the 'iperf' program go?"
(if you see 100% CPU usage by 'iperf', you know that OpenVPN is not the
limiting factor), or "how fast is your browser" with the online speed
tests.

> cd ovpn-dco-master/
> vim ./drivers/net/ovpn-dco/udp.c #CONFIG_IPV6 -> #ifdef CONFIG_IPV6_NO
> make
> cp -fv ./drivers/net/ovpn-dco/ovpn-dco-v2.ko ../
> modprobe udp_tunnel
> insmod /root/dco/ovpn-dco-v2.ko

... this is not really what you want, though.  It's the old module which
has been overhauled about 10 times before it was accepted into 6.16
upstream kernel.  So you might hit limitations in the kernel module.

The old module only works with OpenVPN 2.6, while the new module only
works with 2.7 (as of this writing, 2.7_alpha3, but "git master" will
also work).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xUwlYgxWUiWkmOMX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJooYNrAAoJEB2Cnv7KVigSv/UL/34bkd0nWXmePeyG88K0oRHE
QjT3QZtSa8USZ50ykh5ofxb4qAo8mjmKMnh2kgQGm92SWj0jTWWdeTFGvyj5kMLN
yHIWBXiE8yJ4i9IMyvVfSCRM8Go3mCWwpj9Ts/JsnAR/0C+CuMMqP+bBmKJL71OK
94L+8cmOFtAF5OSky3Ysh5jaClIlzwfTEG3fWzJaiBeWMhXQEiFSpjrHPMVBuptl
6qRvR/kJhQXKbDGW7OouJfvoQbxpuAcWQzMY717oEcXdjW/XwuU/61jhT7/4+ggS
ACUPLOO1BkYO/RFgxN5tgz+I7rOtiW6p7cJgQ6vLtPjBoGY2fhgEu6UQzthNiaWM
6P/iOFtcmrAevEciTA8yFFFaZmlHFc+lqubRZfywkOs+WzV83hQcsxXfL+9x5sjJ
sJ4ZxOhYnq9a8FfKVuN7FS88Sf7LNumtpz+2nvmYaBThar/Lmut5lZGaQmnFcDU7
02QMHL+cvbA8rPp45vYY3sElo5PcO7W9brBz2iO1ig==
=iRSg
-----END PGP SIGNATURE-----

--xUwlYgxWUiWkmOMX--

