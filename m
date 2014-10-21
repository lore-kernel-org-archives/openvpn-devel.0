Message-ID: <5446BB89.2090701@...1856...>
Date: Tue, 21 Oct 2014 22:01:13 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <54450921.30501@...515...>	<54461F20.5060908@...1147...>	<20141021091159.GY396@...1296...>	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>	<20141021104308.GZ396@...1296...>	<CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>	<CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>	<20141021142617.GD396@...1296...>	<CAKuzo_jU0AL9w1MZ-mCfp5_+Q=v2xhYfN1L+eKgN1ZsKtUmzLQ@...278...>	<CAKuzo_gHOM3ZJfK5Shu4XcCcuG3qPadwsbQHpNCNwFBR67N4fg@...278...>	<20141021192844.GF396@...1296...>
	<5446B7DE.4030903@...515...>
In-Reply-To: <5446B7DE.4030903@...515...>
Subject: Re: [Openvpn-devel] Fwd: New OpenVPN Windows installers (I004 and
 I604) released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 21-10-14 21:45, Samuli Sepp=E4nen wrote:
>> True, this should have been integrated much sooner.  We expected
>> a 2.4 release early 2014, not "maybe q2 2015" or such, but things
>> did not work out the way as planned due to lots of personal
>> reasons.
> Speaking of 2.4... besides the interactive service what is
> missing?

AES-GCM, but my first try-out patch to work towards it did net get
much response:
http://thread.gmane.org/gmane.network.openvpn.devel/8952

I have a tree with working code, waiting for cleanup, comments and
test here:
https://github.com/syzzer/openvpn/tree/aead-cipher-modes5

I hope to at least get confirmation for this approach (or choose a
different one) during the upcoming face-to-face meeting.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJURruEAAoJEJgCyj0AftKI/VsH/0zMpGNBXV2eeV+UtbiMbATY
ylQjAV010bwhCoN+g/8cCgzUiKJLZ1gW1xsJCoP7wdaFbj6RVRC0Ll1XchChFFOW
qQFf3ecffKYEmI9f10WSwUFpeS9plVDgqSEHSANJbto2wwVPljHM02woPc94Ugow
mcU+nqxgQU6slbMSYMC5C6cO8MVxPpjLoVedQLCRUWYIm5OZ0xo+mdl9z+LFsmzs
6Cx7dzOjwWBuZqn3VtMV6cFLDMf3QG/ECB+G89NpnmZZhYu9NG2oB675jA9znFMp
E9Lwaz2B4aX7cs3T5eg9ve6ZGxMZvzFOSEvyXqRTF6ht2PyenGx6gKW5BNMIZNU=3D
=3DWqmb
-----END PGP SIGNATURE-----

