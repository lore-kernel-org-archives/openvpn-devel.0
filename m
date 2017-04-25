Date: Tue, 25 Apr 2017 16:34:59 -0400
From: Nathan Stratton Treadway <nathanst@...1517...>
Message-ID: <20170425203458.GX14992@...1518...>
References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
MIME-Version: 1.0
In-Reply-To: <1493106641-16173-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] travis-ci: add 2 mingw "build only"
	configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

On Tue, Apr 25, 2017 at 12:50:41 +0500, Ilya Shipitsin wrote:
> Inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13032.html
> build options are taken from regular windows installer builds
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
> v2: moved download/build dependencies into functions, changed cross build

[....]
> +if [ ! -z "${CHOST}" ]; then
> +      #
> +      # openvpn requires at least mingw-gcc-4.9, which is available at xenial repo
> +      #
> +      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" | sudo tee -a /etc/apt/sources.list.d/xenial.list
> +      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list

I haven't been following all the history of this discussion on the list,
but skimming this most recent version of the patch I noticed that the
above-quoted code adds two separate "deb" lines to xenial.list, both of
which include "main".  Presumably that won't actually cause any
problems, but it seemed unlikely to have been intentional....

(I am not familiar with travis, but I take it this code is run in a
context where there's no need to make sure that the "xenial" lines
aren't added repeatedly by multiple runs of this script?)

							Nathan

----------------------------------------------------------------------------
Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
Ray Ontko & Co.  -  Software consulting services  -   http://www.ontko.com/
 GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
 Key fingerprint = 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239

