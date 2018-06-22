MIME-Version: 1.0
References: <20180622014905.21558-1-rosenp@...277...>
 <24a033db-84dc-9d88-eea2-1d0700d8bf01@...2181...>
In-Reply-To: <24a033db-84dc-9d88-eea2-1d0700d8bf01@...2181...>
From: Rosen Penev <rosenp@...277...>
Date: Thu, 21 Jun 2018 19:13:35 -0700
Message-ID: <CAKxU2N-mHrV3NfY9UObGR39i6vXCQWFvX7wKGuB6p7+skJzhPA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn: Add missing OpenSSL includes
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
To: a@...2181...
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Jun 21, 2018 at 6:59 PM Antonio Quartulli <a@...2181...> wrote:
>
> Hi,
>
> On 22/06/18 09:49, Rosen Penev wrote:
> > These get included when deprecated APIs are enabled. This is true on at
> > least version 1.0.2 and 1.1.0.
> >
> > Without deprecated APIs, OpenVPN fails to compile.
> >
> > Signed-off-by: Rosen Penev <rosenp@...277...>
> > ---
> >  ...ilation-with-deprecated-APIs-disable.patch | 148 ++++++++++++++++++
>
> Was this patch committed by accident?
Yeah it was. will resend.
>
> Cheers,
>
>
> --
> Antonio Quartulli

