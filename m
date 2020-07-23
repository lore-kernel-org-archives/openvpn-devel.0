Date: Thu, 23 Jul 2020 21:27:40 +0000
From: =?utf-8?Q?Andr=C3=A9?= <pippin1st+devel@...2282...>
Reply-To: =?utf-8?Q?Andr=C3=A9?= <pippin1st+devel@...2282...>
Message-ID: <2DpwoWW_Jra-FDba6CuiZLqpaQ8sY0OoobPBUXqqWDU4gqsMynlwtjPeLcDtZKmWFIO5rxQhQx9hVnKjIMd0XkGWpe1VQJ4Xhr7MKCLiSwc=@protonmail.com>
In-Reply-To: <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
References: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
 <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Regarding deprecation of --route-nopull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,


> Am 23.07.2020 um 20:14 schrieb Andr=C3=A9 via Openvpn-devel:
>
> > Hi,
> > Regarding,
> > https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--r=
oute-nopull
> > "Openvpn devs would like to know if you use this option".
> > Many pfSense users use this option to policy route.
>
> I would also vote for keeping this option.

I did not vote ;) but ok will give my Senf :)


> Yes you can emulate the
> option by using a number of pull-filter lines but that feels like not a
> good user experience.

One could also say that, --route-nopull does more then just barring routes.
--pull-filter is specific, I would prefer that.


> Also route-pull works in both OpenVPN 2.x and 3.x
> clients while pull-filter is currently 2.x only.

Could change in 3.x too I guess.


W.k.r.
Pippin

