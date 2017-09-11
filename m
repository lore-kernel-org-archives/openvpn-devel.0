References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
Date: Mon, 11 Sep 2017 13:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>
> is someone actually using "tls-verify" in production ?
> we tried to implement additional certificate check using tls-verify
>
>
> while it works in general, in case when it hits "exit 1", it look like a =
timeout from client point of view. it is not any good

do you mean that when a client is denied access (i.e. the tls-verify script=
 exits 1 on the server) that the client sees this as=20
a timeout?=C2=A0 that is "normal" behaviour, as the server does not tell th=
e client *WHY* access is refused - it simply stop=20
responding to a client that does not pass authentication/authorization. The=
 client will not hear from the server, and will time=20
out after a specified interval.=C2=A0 This is actually the most secure way =
to do things, as a rogue client cannot DoS a server this way.

HTH,

JJK


