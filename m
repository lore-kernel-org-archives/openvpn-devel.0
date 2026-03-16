MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-2-luca.boccassi@...277...>
 <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
In-Reply-To: <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Mon, 16 Mar 2026 12:01:38 +0000
Message-ID: <CAMw=ZnQy+i0debrWv2ya=xy12_h1EmrRVfiuKEK9-aWZ6GJRoQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Increase TLS_CHANNEL_BUF_SIZE
 from 2048 to 8192
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 Mar 2026 at 12:00, Arne Schwabe <arne@...1227...> wrote:
>
> Am 16.03.26 um 00:05 schrieb luca.boccassi@...277...:
> > From: Luca Boccassi <luca.boccassi@...277...>
> >
> > When authenticating via a JWT token 2048 bytes are not enough, which
> > breaks the auth process. In my local case the token is ~2100 bytes.
> > Bump the maximum harcoded size from 2k to 8k to leave some headroom.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
> > ---
> >   src/openvpn/common.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> > index aa7b7217..fbe6239a 100644
> > --- a/src/openvpn/common.h
> > +++ b/src/openvpn/common.h
> > @@ -67,7 +67,7 @@ typedef unsigned long ptr_type;
> >    * maximum size of a single TLS message (cleartext).
> >    * This parameter must be >= PUSH_BUNDLE_SIZE
> >    */
> > -#define TLS_CHANNEL_BUF_SIZE 2048
> > +#define TLS_CHANNEL_BUF_SIZE 8192
> >
> >   /* TLS control buffer minimum size
> >    *
>
> This gets a definitive NACK from me. This will cause compatibility
> problems. It might work for your small setup where you can easily patch
> both sides but it is not a good when compatibility with other clients is
> important.
>
> We understand that user+pass is limited but this is not the right
> approach to overcome this limitation.

Hi,

Could you please clarify what you mean by compatibility problems? And
what would be the right approach instead to let the client process
larger passwords? Thanks

