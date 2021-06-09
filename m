References: <20210608152434.1403999-1-arne@...1227...>
 <20210609062656.GM976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <861276db-39ea-8b92-1871-4fba6a753e66@...1227...>
Date: Wed, 9 Jun 2021 12:23:51 +0200
MIME-Version: 1.0
In-Reply-To: <20210609062656.GM976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Add github actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 09.06.21 um 08:26 schrieb Gert Doering:
> Hi,
> 
> On Tue, Jun 08, 2021 at 05:24:34PM +0200, Arne Schwabe wrote:
>> +    steps:
>> +      - name: Install dependencies
>> +        run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
>> +      - name: Checkout ovpn-dco-win
>> +        uses: actions/checkout@...2620...
>> +        with:
>> +          repository: OpenVPN/ovpn-dco-win
>> +          path: ovpn-dco-win
> 
> I'm not totally happy with introducing a DCO dependency here while none
> of the related code is in the tree... but since this is transient and
> should not cause any issues (unless that repo disappears :-) ) it's
> okayish.

I can send a v2 without the DCO stuff

Arne

