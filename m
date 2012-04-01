MIME-Version: 1.0
In-Reply-To: <20120401113759.GZ1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-2-git-send-email-alon.barlev@...277...>
	<20120401113759.GZ1359@...1296...>
Date: Sun, 1 Apr 2012 14:52:46 +0300
Message-ID: <CAOazyz0eBQK2iSwHrZmt1GA7BtfGi5b+yvQXe6Ug2514vJamzw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] cleanup: avoid using ~0 - generic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

On Sun, Apr 1, 2012 at 2:37 PM, Gert Doering <gert@...1296...> wrote:
> There is a similar bit of code in the win32 section, in
> get_default_gateway_row():
>
> get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
> {
> =C2=A0struct gc_arena gc =3D gc_new ();
> =C2=A0DWORD lowest_metric =3D ~0;
>
> ... which might also be a candidate for this change. =C2=A0As I'm not sure
> whether UINT_MAX is appropriate for a DWORD, I'm not proposing anything
> particular for this occurance.

Right... I need to modify the patch.
But I am not sure UINT_MAX is appropriate...

Alon.

