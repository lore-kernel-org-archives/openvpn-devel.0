MIME-Version: 1.0
In-Reply-To: <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Mar 2018 18:22:41 -0500
Message-ID: <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

...some good stuff snipped...

>
> I'll admit I might see this with a bit too narrow perspective.  But how I have
> understood this issue is that OpenVPN 2.x does not behave correctly as it
> doesn't understand *why* the authentication failed.  If the client side would
> understand why auth failed, then it can query the user for credentials again -
> which I believe should resolve the current issues ... Or have I missed something?

I hope we are slowly spiralling towards a solution; not going around
in circles...

Anyway, to reiterate: we currently have two issues. (i) client is not
told when authentication fails during reneg
and (ii) client doesn't know that auth-gen-token's token is not
reusable across reconnects
(SIGHUP and SIGUSR1).

Fixing (i) does not fix (ii). But (ii) easier to fix although we could
keep arguing whether a forget-token-reconnect should be used or not
etc..
(i) is the trickier, though I'm not convinced it requires so much refactoring.

Anyway, if there is an immediate solution to (i) it may be better to
fix (ii) along with it. Else just fixing (ii) along the lines Arne has
proposed looks like the way to go.

Selva

