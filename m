Date: Tue, 14 Jan 2025 14:47:58 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Z4ZrDm6lW3Fo4wOo@...2685...>
References: <20241231204629.1210040-1-ben.boeckel@...2851...>
 <20241231204629.1210040-2-ben.boeckel@...2851...>
 <5c9cf8c6-be56-4202-bbbc-c9f33daa6527@...2108...>
MIME-Version: 1.0
In-Reply-To: <5c9cf8c6-be56-4202-bbbc-c9f33daa6527@...2108...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] console_systemd: remove the timeout
 when using `systemd-ask-password`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: Ben Boeckel <ben.boeckel@...2851...>, openvpn-devel@lists.sourceforge.net

On Mon, Jan 13, 2025 at 12:44:48PM +0100, David Sommerseth via Openvpn-devel wrote:
> Given the confirmation by Ben in this reply [1], I give this my ACK. I've
> also double checked the git commit log in systemd to verify his finding.
> 
> Acked-By: David Sommerseth <davids@...515...>
> 
> 
> [1] <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30362.html>

I created https://gerrit.openvpn.net/c/openvpn/+/866 in Gerrit from this
patch which contains the following clean-ups to the commit:
 - Fix "Author:" line to not contain "Via OpenVPN-Devel"
 - Add Signed-off-by line to commit message

Doing this as part of an experiment to add mail-submitted patches
to Gerrit.

Regards,
-- 
  Frank Lichtenheld

