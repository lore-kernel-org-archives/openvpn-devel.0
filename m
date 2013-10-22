From: Josh Cepek <josh.cepek@...1085...>
Date: Tue, 22 Oct 2013 14:25:52 -0500
Message-ID: <l46jgo$r7q$1@...1062...>
References: <1381829022-15244-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
In-Reply-To: <1381829022-15244-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] Support non-ASCII TAP adapter names on
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK on this; a local build checks out with all sorts of creative UTF-8
device names I threw at it, including ones with spaces too.

- --
Josh Cepek

On 10/15/13 04:23, Heiko Hund wrote:
> Currently the TAP adapter name is fetched as an OEM string, which
> is problematic if it contains non-ASCII characters and is to used
> with netsh. The logfile also contains these non UTF-8 characters.
> 
> This patch fetches the name from the registry as UCS-2 and converts
> it right into UTF-8 before it's used.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/tun.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 86a43f2..9f53b23 100644
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSZtFAAAoJENcx2Xpgb9RjWeQL/RbLTXgI5i4cEVR5o3pa76Ov
xp28gEyhDlmMDWGiMSKGePQknn3GfymzZ7SgtYnJKercZcqSSMvGefHIK71FQ1R0
D9N17K0KEnEOAEFOLZjBGFITqPVmeDX4mVqLKYh6xOGCeae0BltgpfawOcjUTJ/h
/M6DsrkrSexizPWGa5mr4+kmxbWOJ0rbxeLNQT5neecibB7FWjQXDEpz74HwVMOU
x6FxtAOenFU6XYfFhczK3G1xxyWP1NqZhmNPUiSydAjTvXepzLIPvGocZjfozd22
f/Eyf3MvZuFBF7Xu8QZe1UU+E0kf7ZgMjHwzpNwDhfu4Halc/9NCn4895D8xrAXA
AyUfv3st1+UKdQNIHhyfXQLKP7vWFZYHS9hC3SN8G+wgeamyEP1WoFp1bimaCqhi
jHC/n+5piDN2iOCGe5H11RF+kx+UVxgs7+zyY/VT6zNyLQVnmWl0ynynh/i1hiUo
LsfooT2sRA4KCsGfRzEuEFtsMpqYKhqub+tH3JOYSw==
=xGRO
-----END PGP SIGNATURE-----


