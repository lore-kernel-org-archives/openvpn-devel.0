Message-ID: <547CABE3.9000109@...1856...>
Date: Mon, 01 Dec 2014 18:56:51 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>	<201411301648.sAUGmn3S007220@...1295...>
	<547CA65E.50807@...1114...>
In-Reply-To: <547CA65E.50807@...1114...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: autotools: Fix wrong
 ./configure help screen default values
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 01-12-14 18:33, David Sommerseth wrote:
> On 30/11/14 17:48, Gert Doering wrote:
>> As a matter of discussion, I wonder why we have "default=yes"
>> and "no" in our --help text, and not
>> "default=enabled"/"disabled", which might be slightly less
>> confusing... any autoconf style guides here?
> 
> Do we need the "default=" stuff at all?  Isn't the default state
> quite obvious when you see --enable-feature-abc or
> --disable-feature-xyz?

I don't think we need the "default=" stuff, the --enable/--disable
makes it clear by itself. Would make it easier to keep things
consistent too.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJUfKvaAAoJEJgCyj0AftKIKTkH/2wDn6M/dTibd6isx9vkXooL
goGBk7ISMbpzZlVSQ8sOCqc14hVZ0DUhBlXnmtbPwZnTSfGm/Yol6HIWDxX33q15
rVS6W44BqE7OVeAEfs6JAXccBwNCY/kZfBnaIaX7lrH0PWbEJYeHpgvQg0HILh4Y
eugv1fs7mjWuuEQRxCsy7GZtZoI/h6gxrkC5BFRezhwnL9zqibFI1GbHlsYOtfQ8
CkdKLq6vN9AWQnFfrmycm4lZvwvvo6TonEfUjOiL235U/d9PvRGGBCmCftsV+ho2
BinpGM2wXr9BXYQWdZT3SUpwaCFdCWVoJDSmtYq95CAILc1l8CZ/8iLlvHMpccY=
=uk55
-----END PGP SIGNATURE-----

