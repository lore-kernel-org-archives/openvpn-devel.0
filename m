References: <20180602034206.9459-1-a@...2181...>
 <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
 <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
 <20180604071508.GS79551@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <9d6d4a65-b465-a7fc-92bd-42c65ef34e32@...1147...>
Date: Mon, 4 Jun 2018 10:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180604071508.GS79551@...1296...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 04/06/18 09:15, Gert Doering wrote:
> On Mon, Jun 04, 2018 at 09:10:23AM +0200, Jan Just Keijser wrote:
>> What's the particular use case for putting tls-auth files in connection
>> blocks?
> "I have one existing server that is not using tls-auth yet, and a new one
> that has tls-auth, and I want both in the same config file"
>
> Plus, what Steffan mentioned: tls-auth rollover
>
hmmm, of course, some people even asked me what the best way to do=20
tls-auth rollover is...

I could also see a use case where you have a single config with "proto=20
udp" and "proto tcp" , where the "proto udp" block has a tls-auth key=20
but the "proto tcp" does not=A0 -=A0=A0 the use case for "tls-auth" is most=
ly=20
UDP anyways, as TCP connections are not so easy to protect against DoS=20
attacks.=A0 I assume that will also be possible?

JJK


