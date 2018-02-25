MIME-Version: 1.0
In-Reply-To: <201802201307.w1KD7SSm067564@...2054...>
References: <20180115080555.18202-1-chipitsine@...277...>
 <201802201307.w1KD7SSm067564@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 24 Feb 2018 22:26:29 -0500
Message-ID: <CAKuzo_gBA8iHFH8oOyeRdwyn6a=X2BwV3i6J7aVx7CLr2HerCg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: modify openssl
 build script to support openssl-1.1.0
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
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Feb 20, 2018 at 8:07 AM, Gert Doering <gert@...1296...> wrote:
> Your patch has been applied to the master and release/2.4 branch.
>
> commit 437be780996501becb18f0d34c256ab9c9fe27af (master)
> commit b7aea67aa11b73417eeff595d13b0e2a7b9c925c (release/2.4)
> Author: Ilya Shipitsin
> Date:   Mon Jan 15 13:05:55 2018 +0500
>
>      travis-ci: modify openssl build script to support openssl-1.1.0
>

This added openssl 1.1.0 to the build matrix, but only for Linux, it seems.

Can we also have an openssl 1.1.0 based build for windows? Or
replacing the current ones with 1.1.0 will also do, I suppose.

Thanks,

Selva

