
---

##  `DATABASE_BACKUP.md` 

```markdown
# Database Backup & Recovery Guide

## Why Backup?
- Prevent data loss
- Recover from accidental deletion
- Restore to a previous state for testing

## Method 1: Using mysqldump (Command Line – Recommended)

### Backup
```bash
mysqldump -u root -p orphanage_db > orphanage_backup_$(date +%Y%m%d_%H%M%S).sql