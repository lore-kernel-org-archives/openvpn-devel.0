Date: Sun, 5 Dec 2021 12:16:56 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1302542561.460963.1638703016633@...2642...>
In-Reply-To: <YaySTbKDclfC6PWL@...1296...>
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
 <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
 <YaySTbKDclfC6PWL@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net



> Gert Doering <gert@...1296...> hat am 05.12.2021 11:19 geschrieben:
> 
>  
> Hi,
> 
> On Sun, Dec 05, 2021 at 03:57:55AM +0100, Arne Schwabe wrote:
> > > The refactoring makes it very hard to see what the actual change is. Maybe it would be better to split this in two commits?
> > > 
> > > The only actual change in behavior is the "|| o->pull", right?
> > 
> > Yes. But should I really split up this 5 line patch into two patches? 
> > That feels a bit excessive.
> 
> I'm fine with a single patch here.
> 
> I need to think a bit more into "what conditions is this checking, exactly,
> and why?" - but with refactoring, I'd have to do that thinking twice :-)

I disagree. If you had one patch that does refactoring but does not intend any functional change,
and one patch that just adds "|| o->pull", the general understanding of each patch would require
much less time and thinking. Mostly it would be much easier to match the change with the intent
communicated by the commit message. Which for me was the hardest part, here.

Regards,
  Frank

--
Frank Lichtenheld

