MIME-Version: 1.0
References: <20230105022718.1641751-2-selva.nair@...277...>
 <20230106150412.1667492-1-selva.nair@...277...>
In-Reply-To: <20230106150412.1667492-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 9 Jan 2023 09:50:10 +0200
Message-ID: <CAGyAFMU1nK+DrfneWc_zfwkqhUSVbGfTbjkwGgDw2n6fmhYfhQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Distinguish route addition
 errors from route already exists
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

I reviewed v1, checked that true/false has been replaced with 0/1/2.
Checked that the only change in v2 is that "succeeded/skipped" is
replaced with "succeeded".

Compiled and tested, looks good.

Acked-by: Lev Stipakov <lstipakov@...277...>

