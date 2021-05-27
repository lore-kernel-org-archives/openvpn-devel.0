MIME-Version: 1.0
References: <20210525173838.3969-1-selva.nair@...277...>
 <202105270711.14R7BOiW072533@...2054...>
In-Reply-To: <202105270711.14R7BOiW072533@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 27 May 2021 11:40:59 -0400
Message-ID: <CAKuzo_j8+Kp_89t=wxQMtNbav+FuDnzooh=Vt3FtTBUOH8WMng@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Print format spec changes
 for tapctl and openvpnmscia
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Thu, May 27, 2021 at 3:11 AM Gert Doering <gert@...1296...> wrote:
>
> Have not tested this, just stared a bit at the code.  Did not "fix"
> the "%s v%s" issue Lev pointed out as this will be fixed in the next
> patch...  thanks.
>
> (I do wonder if "support ansi builds" is really something we want, if
> that makes the code so complicated - "always UNICODE" seems to be much
> simpler.  What is the drawback of not supporting "ansi" builds?)

I prefer to write all new Windows code as unicode without any dependency on
the defines UNICODE and  _UNICODE --- i.e no TCHARs, explicit API calls,
no _tprintfs.

For old code, an easy option would be to retain the TCHARs, but assume
we only build with UNICODE (TCHAR=WCHAR) and going forward don't care
to support ANSI builds. As we did with the service.

Even for this part of the code, I suspect ansi build is broken -- we
never test it,
do we.


Selva

