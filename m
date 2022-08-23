Date: Tue, 23 Aug 2022 15:24:12 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwTU/AmxmTG6Szq2@...2685...>
References: <20220823120902.738-1-timo@...2669...>
MIME-Version: 1.0
In-Reply-To: <20220823120902.738-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH] GitHub Actions: Use Docker Images for
 Ubuntu test runs
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Aug 23, 2022 at 02:09:02PM +0200, Timo Rothenpieler wrote:
> The ubuntu-18.04 base image is deprecated and in the process of being phased out:
> https://github.blog/changelog/2022-08-09-github-actions-the-ubuntu-18-04-actions-runner-image-is-being-deprecated-and-will-be-removed-by-12-1-22/
> 
> It is already causing build failures during the scheduled periods mentioned in the blog post.
> 
> This is the best alternative I found which does not drop any tests or test environments.
> Sadly GHAs build-in container-capabilities can't be used, since they don't allow specifying --network host.
> Without that, IPv6 related tests fail, since the Docker deployment on GHA does not support IPv6, even in 2022:
> https://github.com/actions/runner-images/issues/668
> 
> So instead this manually invokes docker to run the tests in the respective Ubuntu Docker-Image.
> Some dependencies had to be added since the Docker-Images are more barebones than the Github-Runner images.
> Otherwise, nothing about the test setup changed.
> ---
>  .github/workflows/build.yaml | 43 ++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 

Basically the question seems to be whether this increase in complexity is worth it for
the additional coverage of the OpenSSL 1.0.2 case. Given that these builds are redundant
with the buildbot builds we do, that seems dubious to me. However, the github actions are
accessible by people outside of the project, so they are definitely not completely
redundant.

Regards,
-- 
  Frank Lichtenheld

