Message-ID: <96550638-91b8-5f63-ebe1-008895d1c795@...2181...>
Date: Mon, 27 Jun 2022 20:50:39 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-20-a@...2181...>
 <CAKuzo_hJcsXQ8UZzXDd_gSSch8wWHoQpp7xx7m99VLpgbDAMKA@...278...>
 <CAGyAFMX47C4tAtwbhxcPc=17fpTOphkf+fBkWJsQZ1FvNhrh_g@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAGyAFMX47C4tAtwbhxcPc=17fpTOphkf+fBkWJsQZ1FvNhrh_g@...278...>
Subject: Re: [Openvpn-devel] [PATCH 19/25] dco-win: implement
 GetOverlappedResultEx for mingw32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

On 27/06/2022 12:30, Lev Stipakov wrote:
> Hi,
> 
> The problem this patch solves appeared on mingw-w64 for 32bit version
> 6.0.0, which is the latest version of mingw on Windows. When this
> patch was written (April 2021), we still used travis/appveyor which
> did mingw builds on Windows so back then patch made sense.
> 
> Since we moved to GHa since the last summer and mingw builds are done
> on Linux with new enough mingw, this patch could be safely removed.
> 
> I dropped this commit and pushed changes to my fork and GHa is happy:
> https://github.com/lstipakov/openvpn/actions/runs/2567640010
> 

The 'dco' branch has been modified accordingly:
* compat patch 19/25 removed;
* code now uses GetOverlappedResultEx() directly.

Cheers,

-- 
Antonio Quartulli

