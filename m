Date: Sun, 3 Sep 2023 13:44:13 -0700
From: orbea <orbea@...2744...>
Message-ID: <20230903134413.090a03ec@...2745...>
In-Reply-To: <ZPTc50Xjm8Eqmger@...1296...>
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...> <20230903095545.0f6d9d03@...2745...>
 <5e877862-457b-7241-f9fd-086adb9fe518@...2181...>
 <ZPTc50Xjm8Eqmger@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 3 Sep 2023 21:22:15 +0200
Gert Doering <gert@...1296...> wrote:

> Hi,
> 
> On Sun, Sep 03, 2023 at 08:15:05PM +0200, Antonio Quartulli wrote:
> > On 03/09/2023 18:55, orbea wrote:  
> > > Here is a patch that preserves the version check and adds a second
> > > check for OPENSSL_NO_ENGINE which seems to also be useful for
> > > BoringSSL.  
> > 
> > I prefer this version, but I'll let other chime in.
> > On top of that I think we may need a proper v2 PATCH having no
> > extra body, as I am not sure your message can be properly parsed by
> > git-am.  
> 
> It should be fine, and if not, I'll massage it to make it go in.
> 
> gert

Thank you, the patch was generated with 'git format-patch' so I would
think 'git am' can consume it, but please let me know if there is
anything else I can change.

