Message-ID: <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
Date: Fri, 24 Mar 2023 19:30:51 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230323143140.76949-1-frank@...2641...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <20230323143140.76949-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 23.03.23 um 15:31 schrieb Frank Lichtenheld:
> Currently this is not obvious since we never build the
> UTs with MSVC, but it doesn't like the initializers with
> "const" variables. They cause
> error C2099: initializer is not a constant

What MSVC version are you using? What options? I've tried with a minimal
C program with static const char *const foo =3D "something"; and it
compiled with the latest 2017 or 2022 MSVC.

How are you connecting the unit test to the build?

> when used in an initializer.
> So change all of them to preprocessor defines instead.
>
> It also doesn't like the empty initializer.

Of course not, because it's ill-formed code prior to C23.

So, NAK.



