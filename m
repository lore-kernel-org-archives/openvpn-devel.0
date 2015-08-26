References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55DD7A68.5060603@...1227...>
Date: Wed, 26 Aug 2015 10:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
Content-Type: multipart/alternative;
	boundary="------------000304080000020009020608"
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
 Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000304080000020009020608
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 26.08.15 um 03:43 schrieb Rafael Gava:
> Hi, 
>
> this is my first submission to the list and I hope that I'm doing in
> the right way. :-)
>
Yes submitting patches to the list is the preferred way. I haven't
looked in the patch yet. I am first trying to understand the goal of the
patches.
>
> Well, the features added to Network Address Translator are:
>
> 1) Allow the user to use the string "localhost" on the client-nat
> network configuration in a way that is not necessary to inform the IP
> address beforehand. Openvpn will set the dynamic received IP from DHCP. 
> Example:
>
> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
> 'localhost' string with the DHCP address received from openvpn server.

I am not sure what you trying to achieve here? Forward all packets
intended for this host to another?
> 2) Allow the user to enable the FTP NAT support through the
> --enable-nat-ftp-support option. 
> This is useful for systems that don't have conntrack-tools support,
> for example on Windows systems. On windows this feature is enabled by
> default.
>
> enable-nat-ftp-support (yes | no)
>
Okay yes. Active FTP is broken by our simple nat implementation. But I
think FTP, let alone active FTP is dead. I am not sure if we should
support this in our simple NAT implementation.

Arne

--------------000304080000020009020608
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <br>
    <div class=3D"moz-cite-prefix">Am 26.08.15 um 03:43 schrieb Rafael
      Gava:<br>
    </div>
    <blockquote
cite=3D"mid:CAAWBBYNiMbWmBgtp1cMc=3DPz9V5dBwr71nOfdEOVWYfWg=3D_HtNA@...278.=
.."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>Hi,=A0</div>
        <div><br>
        </div>
        <div>this is my first submission to the list and I hope that I'm
          doing in the right way. :-)</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    Yes submitting patches to the list is the preferred way. I haven't
    looked in the patch yet. I am first trying to understand the goal of
    the patches.<br>
    <blockquote
cite=3D"mid:CAAWBBYNiMbWmBgtp1cMc=3DPz9V5dBwr71nOfdEOVWYfWg=3D_HtNA@...278.=
.."
      type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>Well, the features added to Network Address Translator are:</d=
iv>
        <div><br>
        </div>
        <div>1) Allow the user to use the string "localhost" on the
          client-nat network configuration in a way that is not
          necessary to inform the IP address beforehand. Openvpn will
          set the dynamic received IP from DHCP.=A0</div>
        <div>Example:<br>
        </div>
        <div><br>
        </div>
        <div><span class=3D"" style=3D"white-space:pre">	</span>client-nat
          snat localhost 255.255.255.255 172.20.1.15 # replaces the
          'localhost' string with the DHCP address received from openvpn
          server.</div>
      </div>
    </blockquote>
    <br>
    I am not sure what you trying to achieve here? Forward all packets
    intended for this host to another?<br>
    <blockquote
cite=3D"mid:CAAWBBYNiMbWmBgtp1cMc=3DPz9V5dBwr71nOfdEOVWYfWg=3D_HtNA@...278.=
.."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>2) Allow the user to enable the FTP NAT support through the
          --enable-nat-ftp-support option.=A0</div>
        <div>This is useful for systems that don't have conntrack-tools
          support, for example on Windows systems. On windows this
          feature is enabled by default.</div>
        <div><br>
        </div>
        <div><span class=3D"" style=3D"white-space:pre">	</span>enable-nat-=
ftp-support
          (yes | no)</div>
        <br>
      </div>
    </blockquote>
    Okay yes. Active FTP is broken by our simple nat implementation. But
    I think FTP, let alone active FTP is dead. I am not sure if we
    should support this in our simple NAT implementation.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------000304080000020009020608--

