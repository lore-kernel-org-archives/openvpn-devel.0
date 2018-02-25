MIME-Version: 1.0
In-Reply-To: <1519505853-11340-1-git-send-email-selva.nair@...277...>
References: <9d49e636-9208-772e-7669-1bbe98a440c4@...1856...>
 <1519505853-11340-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 24 Feb 2018 19:59:11 -0500
Message-ID: <CAKuzo_hvm+-DESErGHqELs5n01BcU-sFNzCjLVfruHnnYQteEw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Support EC certificates with
 cryptoapicert
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sat, Feb 24, 2018 at 3:57 PM,  <selva.nair@...277...> wrote:
> From: Selva Nair <selva.nair@...277...>
>
> Requires openssl 1.1.0 or higher
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> v3 changes:
>  - check return value of ECDSA_SIG_set0
>  - ensure buffer size needed by i2d_ECDSA_SIG does not exceed the expected
>    capacity of the sig buffer
>  - Fix a typo and add contextual info to a debug message
>  - Remove an superflous cast leftover from an older version
>

darn.. forgot to add cleanup calls (ECDSA_SIG_free()) needed when
those added checks fail..

Ignore v3, v4 is coming.

Selva

