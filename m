Message-ID: <f3d3347e-6f4a-4c5e-31f4-d95e34fb2053@...1227...>
Date: Tue, 4 Jul 2023 16:13:50 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20230704130902.105585-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230704130902.105585-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] CMake: Support doc builds on Windows
 machines that do not have .py file association
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 04.07.23 um 16:09 schrieb Frank Lichtenheld:
> On Windows we might need to call python because .py files are not
> directly executable. This is true e.g. for GHA runners.
> For now we assume that rst2html and rst2man can be handled in the same
> way and do not test both of them.
> 
> Commit e8881ec6dd63bd80ce05202573eac54ab8657fcb unconditionally
> used $PYTHON, but that broke build on systems where the default
> python can't be used and we need to respect the shebang.
> Commit 5dbec1c019d14880ae7bf364b062d3589c7fd9e7 unconditionally
> did not use $PYTHON, but that broke build on the aformentioned
> GHA runners.
> This commit tries to establish a solution that works for both
> systems.
> 

This is annoying and should be necessary but I also don't have no better 
idea how to handle this better.

Acked-BY: Arne Schwabe <arne@...1227...>

