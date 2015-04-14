MIME-Version: 1.0
In-Reply-To: <20150414204824.GE382@...1296...>
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
	<20150414204824.GE382@...1296...>
From: Yegor Yefremov <yegorslists@...1030...>
Date: Tue, 14 Apr 2015 23:03:12 +0200
Message-ID: <CAGm1_ksz4NqyaLs13DFHzRUG8dTeandE1OOGbEhQS53ms4PSLA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Apr 14, 2015 at 10:48 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Apr 14, 2015 at 08:34:05PM +0200, Yegor Yefremov wrote:
>> +# enable silent build
>> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
>> +
>
> I don't understand autoconf magic well enough to understand what that
> does - do you have a pointer for me which would explain it?

I don't understand autoconf magic either :-)

But this site https://autotools.io/automake/silent.html explains the
silent build feature. For me, it makes build output cleaner, so that
warnings and errors can be better distinguished from the normal build
output. Many projects use this feature.

Yegor

