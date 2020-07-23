References: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
Date: Thu, 23 Jul 2020 22:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
Content-Language: en-GB
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
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 23.07.2020 um 20:14 schrieb André via Openvpn-devel:
> Hi,
>
> Regarding,
>  https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--route-nopull
>  "Openvpn devs would like to know if you use this option".
>
> Many pfSense users use this option to policy route.

I would also vote for keeping this option. Yes you can emulate the
option by using a number of pull-filter lines but that feels like not a
good user experience. Also route-pull works in both OpenVPN 2.x and 3.x
clients while pull-filter is currently 2.x only.

Arne


