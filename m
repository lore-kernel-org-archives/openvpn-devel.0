MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170629142119.29502-1-logout@...260...>
References: <20170629142119.29502-1-logout@...260...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 29 Jun 2017 16:29:52 +0200
Message-ID: <CAKh=nwHE+PVptbZ4JmDLH1DwNs9fofn4aPhU6-CB4oyK6sLUXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] OpenSSL: remove
 EVP_CIPHER_CTX_new() from the compat layer
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
To: openvpn-devel@lists.sourceforge.net

Hi,

For the two patches in this series, I failed to correctly write
"writer", which I spelled "write", sorry for that. And sorry to said
writer for the gratuitous attack (but then, I'm me, and I'm pretty
sure I'll be able to handle that). And I forgot to mention that the
EVP_CIPHER_CTX_free() function is broken (good thing it has never been
used) since it leaks memory.

For the record, I found this (kinda stupid?) mistake while I was
writing yet another shim to openssl 1.1. I started a discussion on the
openssh mailing list and it seems that supporting a shim in openssh is
the least prefered idea for a few people, right after "not supporting
openssl 1.1 at all". The idea would then to have an independant shim
that would cover the needs for various openssl-based projects. I'm
doing my tests on openvpn since it's the easy way (for me).

So: sorry for the annoying noise :)

Best regards,

-- Emmanuel Deloget

