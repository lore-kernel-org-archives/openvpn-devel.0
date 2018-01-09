MIME-Version: 1.0
In-Reply-To: <1515378076-5774-1-git-send-email-selva.nair@...277...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 9 Jan 2018 10:19:35 +0100
Message-ID: <CAA1Abx+vjp-m1bLfDYHE0NftJ7QagpCib4frnF_JM0KUR034mg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Make cryptoapicert work with TLS 1.2
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 8 January 2018 at 03:21,  <selva.nair@...277...> wrote:
> I am not sure how receptive the crypto maintaineres are to the
> idea of adding more code into cryptoapi.c, but here goes:
>
> I've been wanting to add TLS 1.2 support for certs in the
> Windows cert store using management external key. But that's
> a lot more work than extending cryptoapicert support. And,
> rather surprsingly, it turns out that the CNG API for signing is
> easy to use (well after some groping in the dark..) and doesn't
> take much to implement.
>
> So these patches..
>
> The first patch is not really related and to make the existing code
> "openssl-1.1 ready" (missed by past patches as no one probably builds
> Windows binary with 1.1..).
>
> The second patch is not dependent on this, but close-by code paths
> are touched by both.

This would fix a major shortcoming in our current cryptoapi code, so
I'm definitely open to accepting these patches. Just need to find some
time to do the review and dreaded windows testing :)

I actually tried this myself a while ago, but quickly gave up after
getting lost in and demotivated by the MSDN maze. So more than
grateful that you wrestled your way through!

-Steffan

