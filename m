Message-ID: <c1bceec7-187e-4ed4-ba89-b368d7d0f05a@...1227...>
Date: Sun, 5 Dec 2021 19:04:01 +0100
MIME-Version: 1.0
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
 <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
 <YaySTbKDclfC6PWL@...1296...>
 <1302542561.460963.1638703016633@...2642...>
 <YaylGFdqxlCPwJNc@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YaylGFdqxlCPwJNc@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 05.12.2021 um 12:40 schrieb Gert Doering:
> Hi,
>
> On Sun, Dec 05, 2021 at 12:16:56PM +0100, Frank Lichtenheld wrote:
>>> I need to think a bit more into "what conditions is this checking, exactly,
>>> and why?" - but with refactoring, I'd have to do that thinking twice :-)
>> I disagree. If you had one patch that does refactoring but does not intend any functional change,
>> and one patch that just adds "|| o->pull", the general understanding of each patch would require
>> much less time and thinking.
> True, but the second patch would not be correct, then :-) - as it
> actually adds more conditions than just "o->pull".  The original code
> does not check for socks.


The original code checks for socks. That is not changed.  The orignal 
code basically has two ifs that checks for the code that is !bind_need 
and the particular condition (socks or tcp-client)

>
> I am not exactly happy with the *new* code, as it is still too convoluted
> for my coffee level ("if (!bind_needed && conditions) set bind_local=false",
> what are these conditions?  why?)

I can add more comments to the code. bind_needed is basically if the 
options have a condition that forces binding anyway.

>   but I do not think an intermediate
> patch will make these particular conditional contortions easier...
>

