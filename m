Date: Tue, 29 Apr 2025 11:06:57 +0000
From: Klemens Nanni <kn@...2273...>
In-Reply-To: <a82d032f-4010-4368-b667-1f398ac309cb@...1227...>
References: <20250428214629.49104-1-kn@...2273...>
 <a82d032f-4010-4368-b667-1f398ac309cb@...1227...>
Message-ID: <D140E24D-4861-42A9-BFE0-D400EF95563B@...2273...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [SPAM] [PATCH] Skip tmp-dir check unless
 actualy used
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

29 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F 2025=E2=80=AF=D0=B3. 08:24:12 UTC, =
Arne Schwabe <arne@...1227...> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>There are more instances where the tmp dir is used. Just to name one of th=
e top of my head is tls-crypt-v2-verify. I wonder if the benefit herre is b=
ig enough. As you said, even in your ro scenario it can be workarounded wit=
h specifying an existing directory.

Right, so docs need more fixing.

It is a marginal benefit indeed, but nevertheless strikes me as "correct".

I'll go over the code come back with a manual patch.
Afterwards there be a second iteration of this one.

Thanks.


