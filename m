References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471023669-25102-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cac2ceb2-60a7-27cf-385a-ea26d427d7bf@...1227...>
Date: Fri, 12 Aug 2016 20:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <1471023669-25102-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change timestamps to ISO 8601 format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 12.08.16 um 19:41 schrieb Gert Doering:
> All our timestams used to be "what ctime()" produces, which is
> 
>   "Thu Aug 11 21:15:27 2016"
> 
> Changed to use ISO 8601 standard format, which is
> 
>   "2016-08-11 21:15:27"
> 
> this applies to logging (except to syslog or if --machine-readable-ouput
> is used) and to various other places where informational timestamps are
> produced.  Among these are the status files / status to management
> interface, so applications parsing these time stamp need to be adjusted.
> 
> trac#719
> 
> v2: changes.rst, and correctly call this "ISO 8601" not "POSIX"
> 
ACK from me. I would have used strfrtime but I am fine with this manual way.

Arne


