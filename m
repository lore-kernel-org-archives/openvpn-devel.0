Date: Tue, 19 Sep 2023 18:01:51 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZQnF76KArim2WHQ5@...2685...>
References: <20230919155635.708557-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20230919155635.708557-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] CMake: various small non-functional
 improvements
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
To: openvpn-devel@lists.sourceforge.net

On Tue, Sep 19, 2023 at 05:56:35PM +0200, Frank Lichtenheld wrote:
> These are based on review comments for the 2.6 backport.
> But since they apply to the original master implementation
> as well, I address them in this separate patch.
> 
> - Add documentation to contrib/cmake/*.py
> - Fix grammar in README.cmake.md
> - Update a TODO in CMakeLists.txt to better reflect
>   the status quo
> - Fix indentation in unit_tests' Makefile.am
> 
> Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> Acked-by: Lev Stipakov <lstipakov@...277...>
> ---
> 
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.
> 
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/342
> This mail reflects revision 1 of this Change.
> Acked-by according to Gerrit (reflected above):
> Acked-by: lstipakov <lstipakov@...277...>
> 
> Manual changes:
>  - Fixed Lev's name in Acked-by line.

This is a test email for an idea of mine to resolve the current issues
in integrating Gerrit into our workflow by extracting all the
information about a reviewed change from Gerrit and submit them to the
list in the traditional format so that Gert can apply the usual process
for merging.

Feedback welcome.

I will post the script for review as well.

Regards,
-- 
  Frank Lichtenheld

