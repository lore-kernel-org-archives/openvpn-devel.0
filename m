Message-ID: <535CC38F.5030701@...1856...>
Date: Sun, 27 Apr 2014 10:45:03 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1398585348-7969-1-git-send-email-steffan@...1856...>
In-Reply-To: <1398585348-7969-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Change signedness of hash in
 x509_get_sha1_hash(), fixes compiler warning.
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 27-04-14 09:55, Steffan Karger wrote:
> hash was cast from char * to unsigned char * at the return of the function.
> This patch removes the implicit cast by declaring hash as unsigned char * .

Ignore the "1/2". This was meant as a separate patch, but git
format-patch added the "1/2" without me noticing.

-Steffan

