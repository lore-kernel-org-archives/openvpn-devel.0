MIME-Version: 1.0
In-Reply-To: <20090127135710.GA28793@...1119...>
References: <20090127135710.GA28793@...1119...>
Date: Tue, 27 Jan 2009 19:07:37 +0200
Message-ID: <9e0cf0bf0901270907v160855a1p65b01643bda7059@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc15 GCC 2.96 incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jos Vos <jos@...1120...>
Cc: openvpn-devel@lists.sourceforge.net

Added to:
http://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-oldgcc

Up to james to merge.

On 1/27/09, Jos Vos <jos@...1120...> wrote:
> Hi,
>
>  While there were some incompatibilities with older GCC releases
>  resolved from RC9 to RC15 (I didn't try the releases RC10-RC14),
>  a new incompatibility was introduced concerning the C preprocessor
>  in ssl.c: #ifdef's in macro calls do not seem to be allowed with
>  GCC 2.96.
>
>  Attached a brute-force patch to fix that.  This patch was tested
>  on Red Hat Linux 7.3 with GCC 2.96.
>
>  Regards,
>
>
>  --
>  --    Jos Vos <jos@...1120...>
>  --    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
>  --    Amsterdam, The Netherlands        |     Fax: +31 20 6948204
>
> ------------------------------------------------------------------------------
>  This SF.net email is sponsored by:
>  SourcForge Community
>  SourceForge wants to tell your story.
>  http://p.sf.net/sfu/sf-spreadtheword
> _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>

