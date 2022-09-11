Date: Sun, 11 Sep 2022 12:02:42 +0200 (CEST)
Message-Id: <202209111002.28BA2gYe031416@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220824110930.73009-1-arne@...1227...>
References: <20220824110930.73009-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement --client-crresponse
 script options and plugin interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this on the server test bed, to ensure it does not
"drive by" break anything else (doesn't look like it, but testing is
better).  Doesn't :-) - I have not actually tested the CRRESPONSE script
functionality.

I have slightly changed the commit message, to fix grammar/typo.

Looking at the discussions around the error message and the resulting
code (why not exit early on "if (!tmp_file)"?) I wonder why we do not
have a more generic "create a tmp_file, fill it with $string, do
proper error messages, return true/false" function for this... and 
what this "status_open()" stuff is about, for wrting a plain text file.

But this is for a separate cleanup/refactoring patch.


On the patch itself, since this does not introduce new asynchronous
authentication, just extra hooks that are done (or not) and can succeed
synchronously (or not), the changes should be fine.  Heiko and David
already reviewed this.

Next: 11/11 v4 + ACK, please :-)

Your patch has been applied to the master branch.

commit 23eec2d29435a51771dcd4f85d71f33465a174ff
Author: Arne Schwabe
Date:   Wed Aug 24 13:09:30 2022 +0200

     Implement --client-crresponse script options and plugin interface

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220824110930.73009-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25089.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


