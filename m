MIME-Version: 1.0
In-Reply-To: <20170526172134.4124-1-farhan@...515...>
References: <20170526172134.4124-1-farhan@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 29 May 2017 09:21:50 +0200
Message-ID: <CAA1AbxJih_UA1SARcNswV_ZD8SYSUuvhjCDsVMOh57F8Q+kUwg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Added port-share-max option
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
To: Farhan Ul Haq <farhan@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Welcome to the mailing list.

On 26 May 2017 at 19:21, Farhan Ul Haq <farhan@...515...> wrote:
> ---

Well, that is a short commit message.  Before we look into this patch,
could you please supply a commit message that convinces why we would
need this option?  We already have a plethora of options, and don't
want to add any more unless it is really necessary.

The commit message isn't just to make us understand, but also to
provide context for future developers who are searching the git logs
for reasons why something in the code is the way it is.

In general, I'd like to advise you to read this great blog post in
detail before resubmitting:
https://chris.beams.io/posts/git-commit/

Furthermore, just glancing at the code, I noticed:
 * this patch seems to be based on the release/2.3 branch, while
patches should be based on the master branch.  (And we only accept
bugfixes in the release/2.3 branch, so this is very unlikely to be
backported to release/2.3.)
 * this adds an options, but doesn't update the man page
 * this doesn't update Changes.rst

Thanks,
-Steffan

