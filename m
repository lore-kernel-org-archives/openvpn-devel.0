MIME-Version: 1.0
References: <20220120212243.306-1-lstipakov@...277...>
 <CAKuzo_gK2s3uvnu7RPRTJK6YcDOuP+GhUTsv8b2x_9yJ+-cJ_g@...278...>
In-Reply-To: <CAKuzo_gK2s3uvnu7RPRTJK6YcDOuP+GhUTsv8b2x_9yJ+-cJ_g@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 24 Jan 2022 20:56:30 +0200
Message-ID: <CAGyAFMWzNnQioFPgCcVRM2BfUXnZ_Qv6OaWtCgiwBnpFFASBbA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] msvc: switch to openssl3
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

> A whole patch in the commit message is not very helpful and makes it hard to read. Why not include this patch + the original, and apply the patch during build?
>
> Or just add a pointer to the original file in the changed file so that it could be diff-ed against if need be,

Yeah, I was not sure what is the best way to indicate difference
between this one and original one, so I added it to commit message.
Not sure what do you mean by "apply the patch during build" - you can
have patches for port sources but I don't think you can patch the port
script.

Like you proposed I could add a comment to the patched file which
points to original one.

> These changes look sane though I think this should be a separate commit.

I could do that, but then commit without those changes will break the build.

-- 
-Lev

