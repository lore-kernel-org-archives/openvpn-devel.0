Message-ID: <491B5ECF.20805@...1114...>
Date: Wed, 12 Nov 2008 23:55:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [Fwd: Re: [patch] enhance compatibility with
 HTTP/1.1 proxies]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


sorry ... my reply went directly to Matthias Andree instead of mailing list ... fwd. his answer to
mailing list as well

David S.


-------- Original Message --------
Subject: Re: [Openvpn-devel] [patch] enhance compatibility with HTTP/1.1	proxies
Date: Wed, 12 Nov 2008 23:41:18 +0100
From: Matthias Andree <matthias.andree@...68...>
To: David Sommerseth <openvpn.list@...1114...>
References: <200810271301.m9RD1BKT006709@...1141...>
<200811121224.mACCOmfd077621@...1141...> <20081112133657.GA15988@...33...>
<491B56D4.9030203@...1114...>

On Wed, 12 Nov 2008, David Sommerseth wrote:

> Completely agree ... this seems to be a more sensible way to approach this issue.  Seems to be
> pretty fail-safe too.  In this approach it really only depends on the contents of
> p->options.http_version and how sscanf(...) parses it.  And it should be fair to believe that
> sscanf(...) will do a pretty good job.
> 
> Should maybe do some testing how this snippet will work with both sensible http versions (0.8, 0.9,
> 1.0, 1.1, 1.2, 1.00, 1.10, 1.01, 2.0), but also with real garbage (1.1a, GARBAGE, 1.)

Expected output: 1.1a will be parsed as 1.1, GARBAGE and 1. will be
rejected because rc is 0 or 1, respectively.

Otherwise, 0.8, 0.9, and 2.0 should be rejected; 1.0 and 1.00 should use
the 1.0 code branch; 1.1, 1.2, 1.10, 1.01 should use the >= 1.1 branch
on the assumption that >= 1.1 aren't changing Host: semantics.

Let me know if there are differences.

-- 
Matthias Andree

