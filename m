MIME-Version: 1.0
References: <20210826100221.1378-1-chipitsine@...277...>
In-Reply-To: <20210826100221.1378-1-chipitsine@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 26 Aug 2021 13:20:27 +0300
Message-ID: <CAGyAFMUg4FQmOQFP5-UXzjs1=VKUd=gsHajVv0n_XAG6=_sV3Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] CI: github actions: keep "pdb" in
 artifacts
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

Patch is missing SOB line, but I guess this can be fixed by the
committer, if needed?

Checked https://github.com/chipitsine/openvpn/actions/runs/1108264158
so that PDBs are indeed stored as artifacts.

Acked-by: Lev Stipakov <lstipakov@...277...>

