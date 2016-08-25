References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<CAA1AbxK5kCi5_NzeggKNt7+oLCvacMCEG0X4UwWqbzRKraTV=Q@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <17453c3f-f2b5-9cf5-08e4-f59a21c971d7@...2080...>
Date: Fri, 26 Aug 2016 00:36:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1AbxK5kCi5_NzeggKNt7+oLCvacMCEG0X4UwWqbzRKraTV=Q@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/08/16 00:21, Steffan Karger wrote:
> One thing I think might be useful is a timeout that forces a client
> to do a full reauth.  I can imagine a company policy that, for
> example, requires users to perform a 2FA at least every 4 hours.
> I'd want to implement such a policy without stretching the default
> 1 hour renegotiate to 4 hours.  But that might also be too much of
> a corner case which is not worth the extra code...

Good point!

With the input from Selva on the man page update, I started digging
into when such a re-auth really can happen; turns out it's not that
obvious.  So I'll investigate this further and extend the patch-set
accordingly.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXv3MKAAoJEIbPlEyWcf3yvb0P/0LBkV8fUSnsPq2Duy4MT/Gl
OHgoSpC/NcOBNghJQ3DoJBbumtIVtf/GD48O9SLCPSlqsoIVp5+SWMeuQLaiy9OR
kHYW2b3EI8ZOTfnnN1OpTHwSan4m1v792+81SNGp8eaShGsSW7Ib3wxgXnrLWMVy
7vWu7C/giukNI32v0kiAfhfT5L5b8meLCpiGZiqysqejbs5otNWwwLdHK3ZSi/di
dCGIhE5nYwPsXrZNXbEdleGjEb+akAONDVXq8PYIyKkAsizVtTFwr6SLOdi/POg0
WfQh9mIKTCHm53WVA42d/37SGSoPormLT6TLDP0rSqZOWYBlUzsKWe93QpNYiaXe
hhS7F1Vg366JWUCwNywlTKNHYLRtYkckkEaCFnp2stU8sQytjGfeI3tdwolXyxxy
fSwE0FsxZlV0wzCZYwSmhaGcCRconcYOccae2b0ZgSj3n4+RP6P+sFlRgqGVbzjY
kYJh+tDUSxk2gpCAF2P+FjgDqe3E91IP1DA7xW7z6iZdIY+8tTP8t3uZPl9Fissh
MJvG0cRihaqE8aRiK6TCpqPYcGYbdv4CYcrK6F8GCZwm6hHK1n468R5j2sPMu8sy
LysSoTSSCBFVx5EbKRwOJrT4cK3NVUE8Kd+8P2rmKDmv5CaTRlLaFJvvcfs869XS
oU0LuW9S5zDEjHTuYKMs
=Bl/d
-----END PGP SIGNATURE-----

