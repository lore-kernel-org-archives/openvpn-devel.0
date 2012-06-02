MIME-Version: 1.0
In-Reply-To: <4FCA2301.2020307@...1227...>
References: <4FCA1FD3.9020407@...1227...>
	<CAOazyz0Ymgb32cHjWhpjBVC+JRw20tN4oV0aBUhqY7U+zu35nQ@...278...>
	<4FCA2301.2020307@...1227...>
Date: Sat, 2 Jun 2012 17:58:07 +0300
Message-ID: <CAOazyz36=qth=ni9B=rmY7zHaOFAVTukFJH9+fY1FXHMaJx8kw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Build broken on Mac OS X
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
To: Arne Schwabe <arne@...1227...>
Cc: OpenVPN Devel <openvpn-devel@lists.sourceforge.net>

On Sat, Jun 2, 2012 at 5:28 PM, Arne Schwabe <arne@...1227...> wrote:
>>> In the INSTALL file =C2=A0--with-lzo-headers and --with-lzo-lib is ment=
ioned,
>>> which do not work:
>>>
>> <snip>
>>
>>> LZO_CFLAGS=3D"-I/opt/local/include" LZO_LIBS=3D-L/opt/local/lib ./confi=
gure
>> This should have been:
>> LZO_CFLAGS=3D"-I/opt/local/include" LZO_LIBS=3D"-L/opt/local/lib -llzo" =
./configure
>>
>> The -llzo is also needs in XXX_LIBS phrase.
>>
> The INSTALL file then needs to be updated to reflect the change.

Right, this INSTALL is out of date in many other aspects.
I clean up the INSTALL for none windows. I hope it is better now.

Alon

