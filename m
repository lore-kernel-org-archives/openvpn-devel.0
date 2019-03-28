MIME-Version: 1.0
References: <20190327215626.23502-1-rosenp@...277...>
 <20190328075111.GE31008@...1296...>
In-Reply-To: <20190328075111.GE31008@...1296...>
From: Rosen Penev <rosenp@...277...>
Date: Thu, 28 Mar 2019 02:36:18 -0700
Message-ID: <CAKxU2N-1A3xzHbnDp-7t550RSi2aRMx8P-wNKopj7wmZrbYwBA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: Replace not[Before/After]
 functions with get0 variants
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 28, 2019 at 12:51 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Wed, Mar 27, 2019 at 02:56:26PM -0700, Rosen Penev wrote:
> > Also removed initialization with OpenSSL 1.1 as it is no longer needed and
> > causes compilation errors when disabling deprecated APIs.
> >
> > Same with SSL_CTX_set_ecdh_auto as it got removed.
>
> The Subject: line is a bit misleading - shouldn't this be more something
> like "Avoid calling deprecated-API calls of OpenSSL 1.1" or similar?
Yeah. The patch doesn't fully fix it though. I ended up with a
somewhat workable solution though.

https://github.com/neheb/openvpn/commit/945f190a1bfbde3d6bf11f5b576f5c9e5ec1b0f3

I can squash both of these so that they get the same Subject line.
>
> (People *do* look at commit logs, and the current subject does not cover
> making the SSL_library_init() call conditional, etc.)
>
> On the patch itself, I have no strong opinion and would welcome a review
> from Steffan or Arne :-) - the Subject: line I can fix at commit time.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

