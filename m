Message-ID: <32561341-9b11-49a4-a48f-0d3cd6a71e84@...2181...>
Date: Wed, 26 Feb 2025 21:08:37 +0100
MIME-Version: 1.0
References: <CAAWBBYM4L5sg-XJHjvFn+C4BHLB+DHO=AyYC3ey4A3rNUHyFFw@...278...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAAWBBYM4L5sg-XJHjvFn+C4BHLB+DHO=AyYC3ey4A3rNUHyFFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] [master] Add 'assigned-ip' token to
 client-nat network option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 26/02/2025 18:52, Rafael Gava wrote:
>  From 4005dce58440e44bbade4da6cce93da56d12e9ed Mon Sep 17 00:00:00 2001
> From: Rafael Gava <gava100@...277... <mailto:gava100@...277...>>
> Date: Mon, 24 Feb 2025 20:24:20 +0000
> Subject: [PATCH] Added the assigned-ip token to the client-nat network 
> option,
>   enabling the application to dynamically use the client IP provided by the
>   server.

Before looking at the patch we must have a reasonable commit message.
You're still writing everything on one line.

As Frank explained, please write a first single line explaining very 
concisely what the patch does.

Then leave a an empty line and then you can write your bulk and long 
text explaining the what, why and how you are doing things.

The commit in git should look like this:


    This is the commit title, just one line

    Here comes the long text explaining what I have done, maybe
    also why I have done it and especially how.
    I hope this long text will be explicative enough so that
    people will understand my goal and will therefore be able
    to review the patch.

    Signed-off-by: A V <aa@...2865...>


Once you do that, please create the patch by means of the following command:

     git format-patch -1

Git will create a .patch file that you can then attach to your email.
Pasting the patch in an email is a bad idea as the body will likely get
mangled by the email client.


Regards,


-- 
Antonio Quartulli


